T? valueGuardian<T>(dynamic data) {
  if (data == null) {
    return null;
  }

  if (data is T) {
    return data;
  }

  if (T == int) {
    return int.tryParse(data.toString()) as T?;
  } else if (T == double) {
    return double.tryParse(data.toString()) as T?;
  } else if (T == BigInt) {
    return BigInt.tryParse(data.toString()) as T?;
  } else if (T == String) {
    return data.toString() as T;
  } else if (T == bool) {
    final str = data.toString().toLowerCase();
    if (str == 'true' || str == '1') return true as T;
    if (str == 'false' || str == '0') return false as T;
    return null;
  } else if (T == DateTime) {
    return DateTime.tryParse(data.toString()) as T?;
  }

  return null;
}
