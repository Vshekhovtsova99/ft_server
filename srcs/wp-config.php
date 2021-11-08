<!-- // Конфиг для wordpress -->

<?php
/**
* Основные параметры WordPress.
*
* Скрипт для создания wp-config.php использует этот файл в процессе
* установки. Необязательно использовать веб-интерфейс, можно
* скопировать файл в "wp-config.php" и заполнить значения вручную.
*
* Этот файл содержит следующие параметры:
*
* * Настройки MySQL
* * Секретные ключи
* * Префикс таблиц базы данных
* * ABSPATH
*
* @link https://ru.wordpress.org/support/article/editing-wp-config-php/
*
* @package WordPress
*/
// ** Параметры MySQL: Эту информацию можно получить у вашего хостинг-провайдера ** ///
//** Имя базы данных для WordPress * /
define( 'DB_NAME', 'wordpress' );

/** имя пользователя базы данных MySQL */
define( 'DB_USER', 'root' );

/** пароль базы данных MySQL*/
define( 'DB_PASSWORD', '' );

/** Имя хоста MySQL */
define( 'DB_HOST', 'localhost' );

/**Кодировка базы данных для использования при создании таблиц базы данных. */
define( 'DB_CHARSET', 'utf8' );

/** Тип сортировки базы данных. Не меняйте это, если сомневаетесь */
define( 'DB_COLLATE', '' );

/**#@+
 * Уникальные ключи и соли аутентификации.
 *
 * Измените их на разные уникальные фразы!
 * Их можно сгенерировать с помощью {@link https://api.wordpress.org/secret-key/1.1/salt/ службы секретных ключей WordPress.org}.
* Вы можете изменить их в любой момент, чтобы аннулировать все существующие файлы cookie. Это заставит всех пользователей снова войти в систему.
 *
 * @since 2.6.0
 */ 
// поместить уникальную фразу 
define( 'AUTH_KEY',         'put your unique phrase here' );
define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
define( 'NONCE_KEY',        'put your unique phrase here' );
define( 'AUTH_SALT',        'put your unique phrase here' );
define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
define( 'NONCE_SALT',       'put your unique phrase here' );
/**#@-*/

/**
 * Префикс таблицы базы данных WordPress.
 *
 * У вас может быть несколько установок в одной базе данных, если вы дадите каждому
* уникальный префикс. Только цифры, буквы и подчеркивания, пожалуйста!
 */
$table_prefix = 'wp_';

/**
 * Для разработчиков: режим отладки WordPress.
 *
 * Измените это значение на true, чтобы включить отображение уведомлений во время разработки.
 * Разработчикам плагинов и тем настоятельно рекомендуется использовать WP_DEBUG.
 * в своей среде разработки.
 *
 * Для получения информации о других константах, которые можно использовать для отладки,
 * посетить Кодекс.
 *
 * @ ссылка https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/** Абсолютный путь к каталогу WordPress.*/

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/**  Устанавливает переменные WordPress и включенные файлы.  */
require_once( ABSPATH . 'wp-settings.php' );