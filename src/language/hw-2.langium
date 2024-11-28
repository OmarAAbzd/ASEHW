grammar SmartHouse

entry CPSModel :
'repository' '{'
    software+=SoftwareSpecification*
'}'
'market' '{'
  computer+=ComputerSpecification*
'}'
(cpss += CPS)+

;

CPS: 'cps' name = ID  '{' cps+=CPSSpecification* '}';
SoftwareSpecification:
    'software' name=ID
    ('depends' 'on' dependencies+=(ID)+)?
    ('requires' 'memory' memory=INT 'GB')?
    ';';

ComputerSpecification:
    'computer' name=ID
    'processor' frequency=DOUBLE 'GHz'
    ('depends' 'on' dependencies+=[SoftwareSpecification:ID]+)?
    (cores=INT 'cores')?
    'memory' memory=INT 'GB'
    ';';
CPSSpecification:
    (computers += CPSComputer)*
    (connections += CPSConnection)*;

CPSComputer:
    'computer' type = [ComputerSpecification:ID]
    name = ID
     '{'
        (hardware+=CPSHardware | software+=CPSSoftware)*
    '}';

CPSHardware:
    'add' hardwareType=HardwareType;

CPSSoftware:
    'install' software = ID;

CPSConnection:
    from=[CPSComputer:ID] '-o)-' to=[CPSComputer:ID];


HardwareType: types += 'Thermometer' | 'HeatController' | 'SmokeDetector' | 'FireAlarm';


terminal DOUBLE returns number: /[0-9]+.[0-9]+/;
terminal INT returns number: /[0-9]+/;

hidden terminal WS: /\s+/;
terminal ID: /[_a-zA-Z][\w_]*/;

hidden terminal ML_COMMENT: /\/\*[\s\S]*?\*\//;
hidden terminal SL_COMMENT: /\/\/[^\n\r]*/;