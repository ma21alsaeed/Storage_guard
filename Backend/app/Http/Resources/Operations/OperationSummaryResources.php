<?php

namespace App\Http\Resources\Operations;


use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Services\OperationStatusService;
use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\Products\ProductResources;


class OperationSummaryResources extends JsonResource
{

    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $myService = new OperationStatusService();
        return
        [
            'id'             => $this->id,
            'type'           => $this->type,
            'name'           => $this->name,
            'user_id'        => $this->user_id,
            'created_at'     => $this->created_at,
            'updated_at'     => $this->updated_at,
            'finished_at'    => $this->finished_at ? Carbon::parse($this->finished_at) : null,
            'last_temp'      => $myService->getLastTemp($this->sensorReadings),
            'last_humidity'  => $myService->getLastHumidity($this->sensorReadings),
            'avg_temp'       => $myService->getAvgTemp($this->sensorReadings),
            'avg_humidity'   => $myService->getAvgTemp($this->sensorReadings),
            'safety_status'  => $myService->getSafetyStatus($this->products),
            'products_count' => ProductResources::collection($this->products)->count(),
            'readings_count' => SensorReadingsResources::collection($this->sensorReadings)->count()
        ];
    }
}
