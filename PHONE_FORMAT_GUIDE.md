# 📞 Guía de Formato de Teléfono

## ✅ Formatos Aceptados

El sistema ahora acepta números de teléfono en **formato internacional** con gran flexibilidad:

### Ejemplos Válidos

#### Con Código de País (+51 Perú)
- `+51 918 006013` ✅ (con espacios)
- `+51918006013` ✅ (sin espacios)
- `+51-918-006-013` ✅ (con guiones)
- `+51 (918) 006013` ✅ (con paréntesis)

#### Sin Código de País
- `918006013` ✅ (9 dígitos)
- `918 006 013` ✅ (con espacios)
- `918-006-013` ✅ (con guiones)

#### Otros Países
- `+1 202 555 0123` ✅ (Estados Unidos)
- `+34 912 345 678` ✅ (España)
- `+52 55 1234 5678` ✅ (México)
- `+54 11 2345 6789` ✅ (Argentina)
- `+56 2 2345 6789` ✅ (Chile)

## 🔍 Validación

### Reglas de Validación
1. **Longitud**: Entre 9 y 15 dígitos (sin contar símbolos)
2. **Código de País**: Opcional, pero debe empezar con `+` si se usa
3. **Caracteres Permitidos**: 
   - Dígitos (0-9)
   - Símbolo + al inicio
   - Espacios, guiones y paréntesis (se ignoran en validación)

### Proceso de Validación
```dart
// El sistema limpia automáticamente el número
Input:  "+51 918 006013"
Limpio: "+51918006013"
Válido: ✅ (12 caracteres, formato correcto)

Input:  "918 006 013"
Limpio: "918006013"
Válido: ✅ (9 dígitos)

Input:  "12345"
Limpio: "12345"
Válido: ❌ (menos de 9 dígitos)
```

## 🌍 Códigos de País Comunes

| País | Código | Ejemplo |
|------|--------|---------|
| 🇵🇪 Perú | +51 | +51 918 006013 |
| 🇺🇸 EE.UU. | +1 | +1 202 555 0123 |
| 🇲🇽 México | +52 | +52 55 1234 5678 |
| 🇪🇸 España | +34 | +34 912 345 678 |
| 🇦🇷 Argentina | +54 | +54 11 2345 6789 |
| 🇨🇱 Chile | +56 | +56 2 2345 6789 |
| 🇨🇴 Colombia | +57 | +57 1 234 5678 |
| 🇻🇪 Venezuela | +58 | +58 212 1234567 |
| 🇧🇷 Brasil | +55 | +55 11 98765 4321 |
| 🇪🇨 Ecuador | +593 | +593 2 234 5678 |

## ❌ Formatos No Válidos

- `12345` ❌ (muy corto, menos de 9 dígitos)
- `abc123` ❌ (contiene letras)
- `51 918 006013` ❌ (código sin símbolo +)
- `++51918006013` ❌ (doble símbolo +)
- `+` ❌ (solo símbolo sin números)

## 💡 Recomendaciones

### Mejor Práctica
Usa el **formato internacional completo** para evitar confusiones:
```
+[código país] [número local]
Ejemplo: +51 918 006013
```

### Formato Display
El sistema almacena el número tal como lo ingresas, así que:
- Si ingresas: `+51 918 006013`
- Se guarda: `+51 918 006013`
- Se muestra: `+51 918 006013`

### Formato de Entrada Flexible
Puedes escribir de cualquier manera cómoda:
- Con espacios: `+51 918 006 013`
- Con guiones: `+51-918-006-013`
- Sin separadores: `+51918006013`

Todos serán validados correctamente.

## 🔧 Implementación Técnica

### Validación en el UseCase
```dart
bool _isValidPhoneNumber(String phone) {
  // Limpia espacios, guiones y paréntesis
  final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  
  // Valida: + opcional, seguido de 9-15 dígitos
  return RegExp(r'^\+?\d{9,15}$').hasMatch(cleanPhone);
}
```

### Validación en el UI
```dart
validator: (value) {
  final cleanPhone = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  if (!RegExp(r'^\+?\d{9,15}$').hasMatch(cleanPhone)) {
    return 'Formato inválido (ej: +51 918 006013)';
  }
  return null;
}
```

## 📝 Ejemplos de Prueba

### Datos de Prueba - Estudiante 1
```
Nombre: Juan
Apellidos: Pérez García
Email: juan.perez@universidad.edu
Teléfono: +51 918 006013 ✅
Dirección: Av. Universidad 123
Matrícula: EST-2024-001
```

### Datos de Prueba - Estudiante 2
```
Nombre: María
Apellidos: López Martínez
Email: maria.lopez@universidad.edu
Teléfono: 918006013 ✅
Dirección: Jr. Los Estudiantes 456
Matrícula: EST-2024-002
```

### Datos de Prueba - Estudiante 3 (Internacional)
```
Nombre: Carlos
Apellidos: González Ruiz
Email: carlos.gonzalez@universidad.edu
Teléfono: +1 202 555 0123 ✅
Dirección: 1234 Main Street, Washington DC
Matrícula: EST-2024-003
```

## 🆕 Cambios Realizados

### Antes
- ❌ Solo aceptaba números sin espacios
- ❌ Mínimo 10 dígitos fijos
- ❌ No aceptaba formato internacional
- ❌ Input solo permitía dígitos

### Ahora
- ✅ Acepta espacios, guiones y paréntesis
- ✅ Rango flexible: 9-15 dígitos
- ✅ Soporta formato internacional (+código)
- ✅ Input permite escribir símbolos para comodidad

## 🎯 Casos de Uso

### Estudiantes Locales (Perú)
```
Recomendado: +51 918 006013
Alternativa: 918006013
```

### Estudiantes Internacionales
```
Estados Unidos: +1 202 555 0123
España: +34 912 345 678
México: +52 55 1234 5678
```

### Estudiantes con Números Corporativos
```
Con extensión larga: +51 1 234 5678
Número corto local: 234567890
```

---

**Nota**: El sistema es flexible y acepta múltiples formatos, pero **se recomienda usar el formato internacional completo** (+código país + número) para mejor claridad y compatibilidad global.
