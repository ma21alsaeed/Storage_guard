<?php

namespace App\Http\Requests\User;

use Illuminate\Foundation\Http\FormRequest;

class UpdateUserRequest extends FormRequest
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
            'name'     => 'sometimes|string',
            'phone'    => 'sometimes|string|unique:users,phone',
            'password' => 'sometimes|string|min:8|max:30',
            'company'  => 'sometimes|string',
            'location' => 'sometimes|string'
        ];
    }
}
