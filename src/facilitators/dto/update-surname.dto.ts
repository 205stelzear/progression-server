import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateFacilitatorSurnameDto {
	@IsNotEmpty()
	@IsString()
	surname!: string;
}
