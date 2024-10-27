import Foundation

class CacheManager {
  private let fileManager = FileManager.default
  private let cacheDirectory: URL
  
  init() {
    cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }
  
  func saveDataToCache(data: Data, fileName: String) {
    let fileURL = cacheDirectory.appendingPathComponent(fileName)
    do {
      try data.write(to: fileURL)
      print("The data has been written to the cache: \(fileURL.path)")
    } catch {
      print("Error writing data to cache: \(error)")
    }
  }
  
  func loadDataFromCache(fileName: String) -> Data? {
    let fileURL = cacheDirectory.appendingPathComponent(fileName)
    if fileManager.fileExists(atPath: fileURL.path) {
      do {
        return try Data(contentsOf: fileURL)
      } catch {
        print("Cache data read error: \(error)")
      }
    } else {
      print("No data in the cache for the file: \(fileName)")
    }
    return nil
  }
  
  func clearCache(for fileName: String) {
    let fileURL = cacheDirectory.appendingPathComponent(fileName)
    if fileManager.fileExists(atPath: fileURL.path) {
      do {
        try fileManager.removeItem(at: fileURL)
        print("Cache for \(fileName) has been removed.")
      } catch {
        print("Error while deleting cache: \(error)")
      }
    }
  }
}

