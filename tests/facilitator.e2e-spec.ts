import { INestApplication } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import request from 'supertest';
import { seedDb } from '../prisma/functions';
import { AppModule } from '../src/app.module';

beforeAll(async () => {
	await seedDb();
});

describe('FacilitatorController (e2e)', () => {
	let app: INestApplication;

	beforeEach(async () => {
		const moduleFixture: TestingModule = await Test.createTestingModule({
			imports: [AppModule],
		}).compile();

		app = moduleFixture.createNestApplication();
		await app.init();
	});

	afterAll(async () => {
		await app.close();
	});

	it('/ (GET)', async () => {
		const response = await request(app.getHttpServer()).get('/facilitators').expect('Content-Type', /json/).expect(200);

		expect(Array.isArray(response.body)).toBe(true);
		expect(response.body.length).toBe(5);
	});
});
