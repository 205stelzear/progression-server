import { PrismaService } from '$/prisma.service';
import { SocketModule } from '$/socket/socket.module';
import { Test, TestingModule } from '@nestjs/testing';
import { FacilitatorGateway } from './facilitator.gateway';
import { FacilitatorService } from './facilitator.service';

describe('FacilitatorGateway', () => {
	let gateway: FacilitatorGateway;

	beforeEach(async () => {
		const module: TestingModule = await Test.createTestingModule({
			imports: [SocketModule],
			providers: [FacilitatorGateway, PrismaService, FacilitatorService],
		}).compile();

		gateway = module.get<FacilitatorGateway>(FacilitatorGateway);
	});

	it('should be defined', () => {
		expect(gateway).toBeDefined();
	});
});
