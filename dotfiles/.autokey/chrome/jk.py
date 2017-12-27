import time

for key in list(':imap jk <Esc>')+['<enter>']:
  keyboard.send_keys(key)
  time.sleep(0.01)