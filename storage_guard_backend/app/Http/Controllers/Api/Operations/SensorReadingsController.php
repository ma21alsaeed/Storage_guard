<?php

namespace App\Http\Controllers\Api\Operations;

use Carbon\Carbon;
use App\Models\Operation;
use Illuminate\Http\Request;
use App\Models\SensorReadings;
use App\Http\Controllers\Controller;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use App\Http\Resources\Operations\SensorReadingsResources;
use App\Http\Requests\SensorReadings\StoreSensorReadingsRequest;

class SensorReadingsController extends Controller
{
    /**
     * Display the all readings from that operations.
     */
    public function index($operaionId)
    {
        try
        {
            $operation = Operation::findOrFail($operaionId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }
        return response()->json(
            [
            'data' => SensorReadingsResources::collection($operation->sensorReadings)
            ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreSensorReadingsRequest $request, $operaionId)
    {
        try
        {
            $operation = Operation::findOrFail($operaionId);
        }
        catch (ModelNotFoundException $e)
        {
            return response()->json(['message' => 'Operation not found.'], 404);
        }
        // return 'pass';
        $incomingData = $request->validated();
        foreach ($incomingData['readings'] as $reading)
        {
            $sensorReadings = new SensorReadings();
            $sensorReadings->operation_id = $operation->id;
            $sensorReadings->read_at = Carbon::parse($reading['read_at']);
            $sensorReadings->temperature = (double) $reading['temperature'];
            $sensorReadings->humidity = (double) $reading['humidity'];
            $sensorReadings->save();
        }

        return response()->json(
            [
            'message'         => 'The data has been saved.',
            'sensor_readings' => SensorReadingsResources::collection($operation->sensorReadings)
            ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request)
    {
        $data = $request->validate(['sensor_id' => 'required']);

        $sensorReading = SensorReadings::find($data['sensor_id']);
        if (!$sensorReading)
        {
            return response()->json(['message' => 'The record is not found.'], 404);
        }

        $sensorReading->delete();

        return response()->json(['message' => 'The record has been deleted successfully.']);
    }
}
