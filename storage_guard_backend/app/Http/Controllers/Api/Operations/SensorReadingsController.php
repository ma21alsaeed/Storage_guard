<?php

namespace App\Http\Controllers\Api\Operations;

use App\Http\Resources\Operations\SensorReadingsResources;
use App\Models\Operation;
use App\Models\SensorReadings;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Http\Requests\SensorReadings\StoreSensorReadingsRequest;

class SensorReadingsController extends Controller
{
    /**
     * Display the all readings from that operations.
     */
    public function index(Operation $operation)
    {
        return response()->json(
            [
            'data' => SensorReadingsResources::collection($operation->sensorReadings)
            ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreSensorReadingsRequest $request, Operation $operation)
    {
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
    public function destroy(SensorReadings $sensorReadings)
    {
        $sensorReadings->delete();
        return response()->json(['message' => 'The recode has been deleted successfully.']);
    }
}
