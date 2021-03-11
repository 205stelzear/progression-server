import { PrismaService } from '$/prisma.service';
import { SocketModule } from '$/socket/socket.module';
import { Test, TestingModule } from '@nestjs/testing';
import { FacilitatorController } from './facilitator.controller';
import { FacilitatorService } from './facilitator.service';

describe('FacilitatorController', () => {
	let controller: FacilitatorController;

	beforeEach(async () => {
		const module: TestingModule = await Test.createTestingModule({
			imports: [SocketModule],
			controllers: [FacilitatorController],
			providers: [PrismaService, FacilitatorService],
		}).compile();

		controller = module.get<FacilitatorController>(FacilitatorController);
	});

	it('should be defined', () => {
		expect(controller).toBeDefined();
	});
});
