import { PrismaService } from '$/prisma.service';
import { Module } from '@nestjs/common';
import { FacilitatorController } from './facilitator.controller';
import { FacilitatorGateway } from './facilitator.gateway';
import { FacilitatorService } from './facilitator.service';

@Module({
	controllers: [FacilitatorController],
	providers: [FacilitatorGateway, FacilitatorService, PrismaService],
})
export class FacilitatorModule {}
