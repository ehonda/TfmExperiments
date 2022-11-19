# Notes

## Using both target frameworks

In `.csproj`:

```xml
<TargetFrameworks>net6.0;net7.0</TargetFrameworks>
```

Then `net7.0` works:

```console
$ ./run 7.0
Using net7.0
...
Hello, World!
```

but `net6.0` doesn't:

```console
$ ./run 6.0
Using net6.0
...
------
 > [4/4] RUN dotnet build -c Release -f net6.0:
#8 0.616 MSBuild version 17.3.2+561848881 for .NET
#8 1.406   Determining projects to restore...
#8 2.088 /usr/share/dotnet/sdk/6.0.403/Sdks/Microsoft.NET.Sdk/targets/Microsoft.NET.TargetFrameworkInference.targets(144,5): error NETSDK1045: The current .NET SDK does not support targeting .NET 7.0.  Either target .NET 6.0 or lower, or use a version of the .NET SDK that supports .NET 7.0. [/app/TfmExperiments/TfmExperiments.csproj]
------
executor failed running [/bin/sh -c dotnet build -c Release -f net$dotnetVersion]: exit code: 1
```

## Using only `net6.0`

In `.csproj`:

```xml
<TargetFramework>net6.0</TargetFramework>
```

Then `net7.0` doesn't work:

```console
$ ./run 7.0
Using net7.0
...
------
 > [4/4] RUN dotnet build -c Release -f net7.0:
#8 0.672 MSBuild version 17.4.0+18d5aef85 for .NET
#8 2.111   Determining projects to restore...
#8 5.667   Restored /app/TfmExperiments/TfmExperiments.csproj (in 2.92 sec).
#8 6.038 /usr/share/dotnet/sdk/7.0.100/Sdks/Microsoft.NET.Sdk/targets/Microsoft.PackageDependencyResolution.targets(267,5): error NETSDK1005: Assets file '/app/TfmExperiments/obj/project.assets.json' doesn't have a target for 'net7.0'. Ensure that restore has run and that you have included 'net7.0' in the TargetFrameworks for your project. [/app/TfmExperiments/TfmExperiments.csproj]
#8 6.052
#8 6.052 Build FAILED.
#8 6.052
#8 6.052 /usr/share/dotnet/sdk/7.0.100/Sdks/Microsoft.NET.Sdk/targets/Microsoft.PackageDependencyResolution.targets(267,5): error NETSDK1005: Assets file '/app/TfmExperiments/obj/project.assets.json' doesn't have a target for 'net7.0'. Ensure that restore has run and that you have included 'net7.0' in the TargetFrameworks for your project. [/app/TfmExperiments/TfmExperiments.csproj]
#8 6.053     0 Warning(s)
#8 6.053     1 Error(s)
#8 6.054
#8 6.054 Time Elapsed 00:00:00.31
------
executor failed running [/bin/sh -c dotnet build -c Release -f net$dotnetVersion]: exit code: 1
```

## Using base image with both sdks

Works, we can build for either framework. Open questions

* What about a `net7.0` project referencing a `net6.0` project, how do we build that?
* Should we not specify `-f` at all if we have both sdks?

## Ideas

* What about that `project.assets.json` in the error message? ❌
* Build for `net7.0`, run for `net6.0`? ❌
* Base image that has both sdks, use one or the other? ✅
* Why can't we build for just one target framework, having both specified?
