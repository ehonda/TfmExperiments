ARG dotnetVersion=7.0
FROM mcr.microsoft.com/dotnet/sdk:${dotnetVersion}-alpine

ARG dotnetVersion
ENV dotnetVersion=$dotnetVersion
WORKDIR /app
COPY . .
RUN dotnet build -c Release -f net$dotnetVersion

ENTRYPOINT exec dotnet run -c Release -f net${dotnetVersion} --project TfmExperiments/TfmExperiments.csproj
#ENTRYPOINT [ "/bin/sh", "-c", \
#    "dotnet", \
#    "run", \
#    "-c", "Release", \
#    "-f", "net$dotnetVersion", \
#    "--project", "TfmExperiments/TfmExperiments.csproj"]
