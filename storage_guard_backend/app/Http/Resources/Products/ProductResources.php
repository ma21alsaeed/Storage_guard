<?php

namespace App\Http\Resources\Products;

use Carbon\Carbon;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductResources extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id'              => $this->id,
            'name'            => $this->name,
            'description'     => $this->description,
            'production_date' => Carbon::parse($this->production_date),
            'expity_date'     => Carbon::parse($this->expity_date),
            'max_temp'        => $this->max_temp,
            'min_temp'        => $this->min_temp,
            'max_humidity'    => $this->max_humidity,
            'min_humidity'    => $this->min_humidity,
            'safety_status'   => $this->safety_status,
            'created_at'      => $this->created_at,
            'updated_at'      => $this->updated_at,
        ];
    }
}
