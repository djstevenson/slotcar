package Slotcar::Track::Part::Role::LaneChanger;
use Moose::Role;

with 'Slotcar::Track::Part::Role::LaneChanger::Sensors';
with 'Slotcar::Track::Part::Role::LaneChanger::StraightCrossover';

no Moose::Role;
1;
