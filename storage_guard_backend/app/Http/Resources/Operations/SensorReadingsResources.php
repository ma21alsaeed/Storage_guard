<?php

namespace App\Http\Resources\Operations;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SensorReadingsResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return
        [
            'id'           => $this->id,
            'operation_id' => $this->operation_id,
            'temperature'  => $this->temperature,
            'humidity'     => $this->humidity,
            'read_at'      => Carbon::parse($this->read_at)
        ];
    }
}
