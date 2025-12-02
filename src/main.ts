import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger'; // swagger
import { ValidationPipe } from '@nestjs/common'; // swagger

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  //  ✅ 전역 ValidationPipe (DTO 검증)
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      transform: true,
    }),
  );

  // ✅ Swagger 설정
  const config = new DocumentBuilder()
    .setTitle('TURAMI Admin API')
    .setDescription('TURAMI 공연 API 문서')
    .setVersion('1.0.0')
    .addBearerAuth() // 인증
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('docs', app, document); // 최종 URL: http://localhost:3000/docs


  // port 띄우기
  const port = process.env.PORT || 3000;
  await app.listen(port);
  console.log(`Server running on http://localhost:${port}`);
}
bootstrap();





