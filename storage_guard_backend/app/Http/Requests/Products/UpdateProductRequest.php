<?php

namespace App\Http\Requests\Products;

use Illuminate\Foundation\Http\FormRequest;

class UpdateProductRequest extends FormRequest
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
            'name'            => 'sometimes|string',
            'description'     => 'sometimes|string',
            'production_date' => 'sometimes|date',
            'expity_date'     => 'sometimes|date|after:production_date',
            'max_temp'        => 'sometimes|numeric',
            'min_temp'        => 'sometimes|numeric',
            'max_humidity'    => 'sometimes|numeric',
            'min_humidity'    => 'sometimes|numeric',

        ];
    }
}
