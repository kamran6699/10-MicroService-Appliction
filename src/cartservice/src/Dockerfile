# Production Dockerfile (recreated) - cartservice (C# / gRPC)

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS builder
WORKDIR /src

COPY cartservice.csproj ./
RUN dotnet restore cartservice.csproj
COPY . .

RUN dotnet publish cartservice.csproj -c Release -o /out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
WORKDIR /app
COPY --from=builder /out ./

ENV DOTNET_EnableDiagnostics=0
EXPOSE 7070

USER 1000
ENTRYPOINT ["dotnet","cartservice.dll"]

