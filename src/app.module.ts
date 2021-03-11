import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppGateway } from './app.gateway';
import { FacilitatorModule } from './facilitators/facilitator.module';
import { SocketModule } from './socket/socket.module';

@Module({
	imports: [SocketModule, FacilitatorModule],
	controllers: [AppController],
	providers: [AppGateway],
})
export class AppModule {}
