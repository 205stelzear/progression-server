import { Facilitator } from '.prisma/client';
import { MessageBody, SubscribeMessage, WebSocketGateway } from '@nestjs/websockets';
import type { CreateFacilitatorDto } from './dto/create-facilitator.dto';
import { FacilitatorService } from './facilitator.service';

@WebSocketGateway()
export class FacilitatorGateway {
	constructor(private readonly facilitatorService: FacilitatorService) {}

	@SubscribeMessage('send_message')
	handleMessage(@MessageBody() data: CreateFacilitatorDto): Promise<Facilitator> {
		return this.facilitatorService.create(data);
	}
}
