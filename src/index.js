import './main.css';
import { trix } from './trix'
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init({
  node: document.getElementById('root'),
  flags: trix
});

registerServiceWorker();
