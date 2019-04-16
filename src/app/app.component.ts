import { Component } from "@angular/core";
import { environment } from 'src/environments/environment.prod';

@Component({
  selector: "app-root",
  templateUrl: "./app.component.html",
  styleUrls: ["./app.component.css"]
})
export class AppComponent {
  title = "app";
  production = environment.production;
}
