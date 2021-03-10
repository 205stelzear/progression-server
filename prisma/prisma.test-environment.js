// @ts-check
const path = require('path');
const fs = require('fs');
const NodeEnvironment = require('jest-environment-node');

const { pushDb } = require('./functions');

class PrismaTestEnvironment extends NodeEnvironment {
	constructor(config) {
		super(config);

		const randomNum = Math.round(Math.random() * 1000);

		// Generate a unique sqlite identifier for this test context
		this.dbName = `test_${Date.now()}_${randomNum}.db`;
		this.dbPath = path.join(__dirname, 'tmp', this.dbName);

		const dbUrl = `file:./tmp/${this.dbName}`;

		process.env.DATABASE_URL = dbUrl;
		this.global.process.env.DATABASE_URL = dbUrl;

		process.env.SEED = 'test';
		this.global.process.env.SEED = 'test';
	}

	async setup() {
		// Run the migrations to ensure our schema has the required structure
		await pushDb();

		return super.setup();
	}

	async teardown() {
		try {
			await fs.promises.unlink(this.dbPath);
		} catch (error) {
			// doesn't matter as the environment is torn down
		}
	}
}

module.exports = PrismaTestEnvironment;
