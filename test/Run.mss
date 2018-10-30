﻿function Run() {
  plugins = Sibelius.Plugins;

  if (not (plugins.Contains('Test'))) {
    Sibelius.MessageBox('Please install the Test plugin!');
    ExitPlugin();
  }

  pluginDir = GetPluginFolder('sibmei2.plg');
  Self._property:_SibTestFileDirectory = pluginDir & 'sibmeiTestSibs'
      & Sibelius.PathSeparator;

  suite = Test.Suite('Sibelius MEI Exporter', Self, sibmei2);

  suite
    .AddModule('TestExportConverters')
    .AddModule('TestLibmei')
    .AddModule('TestExportGenerators')
    .AddModule('TestUtilities')
  // suite
  //   .AddModule('TestExportGenerators')
    ;

  suite.Run();

}  //$end

function GetPluginFolder(plgName) {
  plgNameLength = Length(plgName);

  for each plugin in Sibelius.Plugins
  {
    path = plugin.File;
    i = Length(path) - 2;
    while (i >= 0 and CharAt(path, i) != Sibelius.PathSeparator) {
        i = i - 1;
    }

    if (Substring(path, i + 1) = plgName) {
      return Substring(path, 0, i + 1);
    }
  }

  Sibelius.MessageBox(plgName & ' was not found');
  ExitPlugin();
}  //$end

function RunLibmeiTests () {
  suite = Test.Suite('Sibelius MEI Exporter', Self, sibmei2);

  suite
    .AddModule('TestLibmei')
    ;

  suite.Run();
}  //$end


function RunGeneratorTests () {
  suite = Test.Suite('Sibelius MEI Exporter', Self, sibmei2);

  suite
    .AddModule('TestExportGenerators')
    ;

  suite.Run();

}  //$end
