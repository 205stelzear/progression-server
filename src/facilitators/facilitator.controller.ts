import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import type { Facilitator } from '@prisma/client';
import { CreateFacilitatorDto } from './dto/create-facilitator.dto';
import { UpdateFacilitatorSurnameDto } from './dto/update-surname.dto';
import { FacilitatorService } from './facilitator.service';

@Controller('facilitators')
export class FacilitatorController {
	constructor(private readonly facilitatorService: FacilitatorService) {}

	@Get()
	async getAll(): Promise<Facilitator[]> {
		return this.facilitatorService.findAll();
	}

	@Get(':id(\\d+)')
	async getOne(@Param('id') id: number): Promise<Facilitator | null> {
		return this.facilitatorService.find(id);
	}

	@Post()
	async create(@Body() data: CreateFacilitatorDto): Promise<Facilitator> {
		return this.facilitatorService.create(data);
	}

	@Post(':id(\\d+)/updateSurname')
	async updateSurname(@Param('id') id: number, @Body() data: UpdateFacilitatorSurnameDto): Promise<Facilitator> {
		return this.facilitatorService.updateSurname(id, data);
	}
}
