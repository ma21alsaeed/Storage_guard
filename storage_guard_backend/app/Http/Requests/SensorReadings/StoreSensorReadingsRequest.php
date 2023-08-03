<?php

namespace App\Http\Requests\SensorReadings;

use Illuminate\Foundation\Http\FormRequest;

class StoreSensorReadingsRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array|string>
     */
    public function rules(): array
    {
        return [
            'readings'               => 'required|array|min:1',
            'readings.*.temperature' => 'required|numeric',
            'readings.*.humidity'    => 'required|numeric',
            'readings.*.read_at'     => 'required|date',
        ];
    }
}
