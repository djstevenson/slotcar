package Slotcar::Track::Part::Role::ARCPro;
use Moose::Role;

with 'Slotcar::Track::Part::Role::ARCPro::FinishLine';
with 'Slotcar::Track::Part::Role::ARCPro::Logo';
with 'Slotcar::Track::Part::Role::ARCPro::LapSensors';

no Moose::Role;
1;
