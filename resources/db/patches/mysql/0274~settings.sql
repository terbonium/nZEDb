INSERT IGNORE INTO settings (section, subsection, NAME, VALUE, hint, setting)	VALUES ('shell', 'date', 'format', '%Y-%m-%d %T', 'Format string to use in shell\'s date command output. See `man date` for acceptable format.\nDefault: %Y-%m-%d %T', 'shell.date.format');
