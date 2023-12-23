import 'package:eshop/Models/DTO/Abstract/DTOObjectBase.dart';

abstract interface class ISaveService {
  Future<bool> AddAsync(DTOObjectBase product);
  Future<bool> DeleteAsync(String productId);
  Future<bool> UpdateAsync(DTOObjectBase product);
  Future<DTOObjectBase> GetByIdAsync(String productId);
  Future<List<DTOObjectBase>> GetAllAsync();
}