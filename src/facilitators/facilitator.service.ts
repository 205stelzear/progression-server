import { PrismaService } from '$/prisma.service';
import { Facilitator } from '.prisma/client';
import { Injectable } from '@nestjs/common';
import type { CreateFacilitatorDto } from './dto/create-facilitator.dto';
import { UpdateFacilitatorSurnameDto } from './dto/update-surname.dto';

@Injectable()
export class FacilitatorService {
	constructor(private readonly prisma: PrismaService) {}

	async findAll(): Promise<Facilitator[]> {
		return this.prisma.facilitator.findMany();
	}

	async find(id: number): Promise<Facilitator | null> {
		return this.prisma.facilitator.findFirst({ where: { id } });
	}

	async create(data: CreateFacilitatorDto): Promise<Facilitator> {
		const { username, password, firstName, lastName, surname, totem, entryDate, inactiveDate } = data;

		const newFacilitator = await this.prisma.facilitator.create({
			data: {
				username,
				password,
				firstName,
				lastName,
				surname,
				totem,
				entryDate,
				inactiveDate,
			},
		});

		return newFacilitator;
	}

	async updateSurname(id: number, data: UpdateFacilitatorSurnameDto): Promise<Facilitator> {
		return this.prisma.facilitator.update({
			where: {
				id: id,
			},
			data: {
				surname: data.surname,
			},
		});
	}
}
