// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import store from "./cs/store";
import main_init from "./cs/main";
import socket from "./socket"
import api from './api';



$(function() {
    let channel = socket.channel("app:", {});
    let root = document.getElementById('root');
    api.request_albums();
    api.request_users();
    //while (store.getState().user_list.length == 0) {}
    main_init(root, store, channel);
});
