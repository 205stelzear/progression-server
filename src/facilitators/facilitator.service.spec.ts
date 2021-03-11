import { PrismaService } from '$/prisma.service';
import { SocketModule } from '$/socket/socket.module';
import { Test, TestingModule } from '@nestjs/testing';
import { FacilitatorService } from './facilitator.service';

describe('FacilitatorService', () => {
	let service: FacilitatorService;

	beforeEach(async () => {
		const module: TestingModule = await Test.createTestingModule({
			imports: [SocketModule],
			providers: [FacilitatorService, PrismaService],
		}).compile();

		service = module.get<FacilitatorService>(FacilitatorService);
	});

	it('should be defined', () => {
		expect(service).toBeDefined();
	});
});
