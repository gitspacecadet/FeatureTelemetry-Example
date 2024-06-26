
/// Adds support for the extension to use the "Telemetry" and "Feature Telemetry" codeunits.
/// </summary>
codeunit 50100 "Sample Telemetry Logger" implements "Telemetry Logger"
{
    Access = Internal;

    procedure LogMessage(EventId: Text; Message: Text; Verbosity: Verbosity; DataClassification: DataClassification; TelemetryScope: TelemetryScope; CustomDimensions: Dictionary of [Text, Text])
    begin
        Session.LogMessage(EventId, Message, Verbosity, DataClassification, TelemetryScope, CustomDimensions);
    end;

    // For the functionality to behave as expected, there must be exactly one implementation of the "Telemetry Logger" interface registered per app publisher
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Telemetry Loggers", 'OnRegisterTelemetryLogger', '', true, true)]
    local procedure OnRegisterTelemetryLogger(var Sender: Codeunit "Telemetry Loggers")
    var
        SampleTelemetryLogger: Codeunit "Sample Telemetry Logger";
    begin
        Sender.Register(SampleTelemetryLogger);
    end;
}

