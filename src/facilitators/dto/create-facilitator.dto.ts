import { IsDate, IsNotEmpty, IsString } from 'class-validator';

export class CreateFacilitatorDto {
	@IsNotEmpty()
	username!: string;

	@IsNotEmpty()
	password!: string;

	@IsNotEmpty()
	firstName!: string;

	@IsString()
	lastName?: string;

	@IsString()
	surname?: string;

	@IsNotEmpty()
	totem!: string;

	@IsNotEmpty()
	@IsDate()
	entryDate!: Date;

	@IsDate()
	inactiveDate?: Date;
}
