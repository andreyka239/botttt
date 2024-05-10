from aiogram import Bot, Dispatcher, executor, types
from aiogram.types.web_app_info import WebAppInfo
bot = Bot('6472540238:AAHrV958Dw_I6E8ZG1eim4QLAUGviJzXRf0')
dp = Dispatcher(bot)
url = 'https://yandex.ru/search/?text=Aiogram+2+(Telegram+Bot+framework)+%D0%BA%D0%B0%D0%BA+%D1%81%D0%BA%D0%B0%D1%87%D0%B0%D1%82%D1%8C&lr=976&clid=2411726'

@dp.message_handler(commands=['start'])
async def start(message: types.Message):
    markup = types.ReplyKeyboardMarkup()
    markup.add(types.KeyboardButton('Открыть веб страницу', web_app=WebAppInfo(url=url)))
    await message.answer('HELLo', reply_markup=markup)
executor.start_polling(dp)