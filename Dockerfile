FROM debian:bookworm AS base

RUN apt-get update -y && apt-get install -y --no-install-recommends pulseaudio squeezelite-pulseaudio mpg123 wget && apt-get clean

RUN wget https://github.com/badaix/snapcast/releases/download/v0.29.0/snapclient_0.29.0-1_amd64_bookworm_with-pulse.deb

RUN sudo apt install snapclient_0.29.0-1_amd64_bookworm_with-pulse.deb
# COPY ["DockerFiles/pulseaudio.service", "/etc/systemd/system/pulseaudio.service"]
# RUN systemctl enable pulseaudio

RUN pulseaudio
RUN squeezelite-pulseaudio
RUN snapclient



# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
# RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
# USER appuser

# FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# ARG configuration=Release
# WORKDIR /src
# COPY ["hassio-announce/hassio-announce.csproj", "hassio-announce/"]
# RUN dotnet restore "hassio-announce/hassio-announce.csproj"
# COPY . .
# WORKDIR "/src/hassio-announce"
# RUN dotnet build "hassio-announce.csproj" -c $configuration -o /app/build

# FROM build AS publish
# ARG configuration=Release
# RUN dotnet publish "hassio-announce.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app/publish .
# ENTRYPOINT ["dotnet", "hassio-announce.dll"]
