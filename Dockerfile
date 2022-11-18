FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine

COPY . .
RUN dotnet build -c Release

ENTRYPOINT ["dotnet", "test", "-c", "Release"]
