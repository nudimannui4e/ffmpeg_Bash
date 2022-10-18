## Describe
Скрипт, для личных целей:
	- ищет все файлы с видео-регистратора
	- создает отсортированный список под ffmpeg
	- склеивает все видео в 1 единый файл

## ffmpeg tldr
Create list of files >
```bash
find <path> -type f -printf "file '%p'\n" | sort > list.txt
```

Create one output_file while readline list.txt
```bash
ffmpeg -safe 0 -f concat -i list.txt -c copy <output_file>
```
