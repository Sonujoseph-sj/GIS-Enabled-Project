<?php require 'header.php';
require 'connection.php';
 ?>
 <script>
  require([
    "esri/config",
    "esri/Map",
    "esri/views/MapView",
    "esri/widgets/Search",
    "esri/widgets/Expand",
    "esri/rest/locator",
    "esri/Graphic",
    "esri/layers/GraphicsLayer"
  ],(esriConfig, Map, MapView, Search,Expand,locator,Graphic,GraphicsLayer)=> {
    esriConfig.apiKey = "AAPK7d9e9e5691de4400beb5f15f352c6142fVO9J6cH_qnluFUuhWTpot5hsXl6xnGqChQpgXKBch0kIDGaxsS_MhPkqy0sUKEm";
    const placesLayer = new GraphicsLayer();
    const map = new Map({
      basemap: "arcgis-navigation", //Basemap layer service
      layers: [placesLayer]
    });

    const view = new MapView({
      container: "viewDiv",
      map: map,
      center: [76.5955013,8.8879509],
      zoom: 14,
      constraints: {
        snapToZoom: false
      }
    });

    view.popup.actions = [];
    view.popup.alignment = "bottom-left";

    const places = [
      ["Coffee shop", "coffee-shop"],
      ["Gas station", "gas-station"],
      ["Food", "restaurant"],
      ["Hotel", "hotel"],
      ["Parks and Outdoors", "park"]
    ];
    const select = document.createElement("select", "");
    select.setAttribute("class", "esri-widget esri-select");
    select.setAttribute(
      "style",
      "width: 175px; font-family: 'Avenir Next'; font-size: 1em"
    );
    places.forEach((p) => {
      const option = document.createElement("option");
      option.value = p[0];
      option.innerHTML = p[0];
      select.appendChild(option);
    });

    view.ui.add(select, "top-left");

    const geocodingServiceUrl = "http://geocode-api.arcgis.com/arcgis/rest/services/World/GeocodeServer";

    function findPlaces(category, pt) {
      locator
        .addressToLocations(geocodingServiceUrl,{
          location: pt,
          categories: [category],
          maxLocations: 25,
          outFields: ["PlaceName","Place_addr","ImageURL"],
        })
        .then((results) => {
          view.popup.close();
          placesLayer.graphics.removeAll();
          results.forEach((result) => {
            placesLayer.graphics.add(
              new Graphic({
                attributes: result.attributes,
                geometry: result.location,
                symbol: {
                  type: "web-style",
                  name: places[places.findIndex(a => a[0] === select.value)][1],
                  styleName: "Esri2DPointSymbolsStyle"
                },
                popupTemplate: {
                  title: "{PlaceName}",
                  content:
                    "{Place_addr}" +
                    "<br><br>"+"<img src='{ImageURL}' alt='Place image'>" +
                    result.location.x.toFixed(5) +
                    "," +
                    result.location.y.toFixed(5),
                },
              })
            );
          });
          if (results.length) {
            // const g = placesLayer.graphics.getItemAt(0);
            view.popup.open({
              features: placesLayer.graphics.toArray(),
              updateLocationEnabled: true,
            });
          }
        });
    }

       // Search for places in center of map
    view.when(() => {
      findPlaces(select.value, view.center);
    });

    // Listen for category changes and find places
    select.addEventListener("change", (event) => {
      findPlaces(event.target.value, view.center);
    });

    // Listen for mouse clicks and find places
    view.on("click", (event)=> {
      view.hitTest(event.screenPoint).then((response) => {
        if (response.results.length < 2) {
          // If graphic is not clicked, find places
          findPlaces(select.options[select.selectedIndex].text, event.mapPoint);
        }});
      });

    // Search term
    const term = "Kerala";
    let automate = true;

    // Add Search widget
    const search = new Search({
      view: view,
    });
    view.ui.add(new Expand({
      view:view,
      content:search,
      expanded:true,
      mode:"floating" }), "top-right");

    // Start suggestions
    view.when(() => {
      search.watch("activeSource", (source) =>{
        search.searchTerm = term.substring(0, 1);
        search.suggest(search.searchTerm);
      })
    });

    // Select last suggestion
    search.on("suggest-complete",(response)=> {
      if (!automate) {
        return;
      }
      if (search.searchTerm.length < term.length) {
        search.searchTerm = term.substring(0, search.searchTerm.length + 1);
        setTimeout(() => {
          search.suggest(search.searchTerm);
        }, 250);
      } else {
        if (response.results.length > 0) {
          search.search(response.results[0].results[0]);
        }
      }
    });

    search.on("select-result",(response)=>{
      if (!automate) {
        return;
      }
      if (response.result) {
        search.suggest(term);
        automate = false;
      }
    });

    search.goToOverride = (view, goToParams)=> {
      if (!automate) {
        return view.goTo(goToParams.target, goToParams.options);
      } else {
        return view.goTo(
          {
            center: goToParams.target.target,
            zoom: 11,
          },
          goToParams.options
        );
      }
    };

    search.on(["search-clear", "search-focus"], () => {
      automate = false;
    });
  });
</script>
  
 <div class="container-fluid d-flex flex-column align-items-between p-0 m-0">
    <div class="header px-3 py-4">
        <div class="namebar d-flex justify-content-between">
        <div class="logo  d-flex gap-2 w-50">
            <img src="images/logo2.png" alt="" class="img-fluid logo-img">
            <h3 class="text-white fs-2 name">Tripadvizor.com</h3>
        </div>
        <div>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container bg">
                  
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                      
                      
                      
                      <li class="nav-item">
                        <a class="nav-link text-white bg p-0 m-0" href="#">Log out</a>
                      </li>
                      
                    </ul>
                  </div>
                </div>
              </nav> 
        </div>
    </div>
    
    </div>
    
        
          
        </div>
        <div class="container-fluid">
            <div class="d-flex flex-column">
              <h3 class="fs-2">location to be</h3>
              <p class="fs-5">District of loction</p>
              <div class="row p-0 m-0">
                <div class="col-12 col-sm-4 p-2">
                  <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                      <div class="carousel-item active">
                        <img src="..." class="d-block w-100" alt="...">
                      </div>
                      <div class="carousel-item">
                        <img src="..." class="d-block w-100" alt="...">
                      </div>
                      <div class="carousel-item">
                        <img src="..." class="d-block w-100" alt="...">
                      </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                      <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                      <span class="carousel-control-next-icon" aria-hidden="true"></span>
                      <span class="visually-hidden">Next</span>
                    </button>
                  </div>
                </div>
                <div class="col-12 col-sm-6 d-flex justify-content-center">
                  <div class="map-to-play w-75">set map herer</div>
                  </div>
                  <div class="container-fluid">
                    <div class="rating">
                      <span class="star" data-rating="1"></span>
                      <span class="star" data-rating="2"></span>
                      <span class="star" data-rating="3"></span>
                      <span class="star" data-rating="4"></span>
                      <span class="star" data-rating="5"></span>
                    </div>
                    <p id="ratingValue"></p>
                  
                    <form action="" method="POST" class="d-flex flex-column">
                      <textarea name="comments" id="comments" cols="50" rows="5" placeholder="Previously visited? Give us your comments." class="my-2 rounded-3"></textarea>
                      <div class="comment-submit w-50">
                        <input type="submit" value="submit" class="btn submit-btn text-white d-inline w-25 mb-2">
                      </div>
                    </form>
                  </div>
                  <div class="container-fluid row p-0 m-0 justify-content-center">
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hotel name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hotel name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hotel name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                  </div>
                  <div class="container-fluid row p-0 m-0 justify-content-center">
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hospitals name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hospitals name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">hospitals name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                  </div>
                  <div class="container-fluid row p-0 m-0 justify-content-center">
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">restaurants name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">restaurants  name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                    <div class="hotels col-12 col-sm-3">
                      <p class="fs-3">restaurants  name</p>
                      <img src="" alt="" class="img-fluid w-100">
                      <div>rating</div>
                    </div>
                  </div>

            '
                </div>
              </div>
            </div>
        </div>
        <div class="footer row px-2 m-0 d-flex  bg w-100 py-4   ">
            <div class="text-start col-12 col-sm-4">
                <p class="text-white  cpwrite">Terms and conditions</p>
            </div>
            <div class="text-start  col-12 col-sm-4">
                <p class="text-white text-center">&copy Tripadvizor.com,2023</p>
            </div>
            <div class="text-start  col-12 col-sm-4">
                <p class="text-white text-end  cpwrite">Privacy Policy</p>
            </div>
        </div>
        <script>
          var map,marker;
          /*Map Initialization*/
          function initMap1(){
              map = new mappls.Map('map', {
                  center: [28.09, 78.3],
                  zoom: 5
              });
              /*Search plugin initialization*/
              var optional_config={
                  location:[28.61, 77.23],
                 pod:'City',
                  bridge:true,
                  tokenizeAddress:true,
                  filter:'cop:9QGXAM',
                  distance:true,
                  width:300,
                  height:300
              };
              new MapmyIndia.search(document.getElementById("auto"),optional_config,callback);
              map.addListener('load',function(){
                  var optional_config = {
                      location: [28.61, 77.23],
                      region: "IND",
                      height:300,
                  };
                  new mappls.search(document.getElementById("auto"), optional_config, callback);
                  function callback(data) {
                      console.log(data);
                      if (data) {
                          var dt = data[0];
                          if (!dt) return false;
                          var eloc = dt.eLoc;
                          var place = dt.placeName + ", " + dt.placeAddress;
                          /*Use elocMarker Plugin to add marker*/
                          if (marker) marker.remove();
                          mappls.pinMarker({
                              map: map,
                              pin: eloc,
                              popupHtml: place,
                              popupOptions: {
                                  openPopup: true
                              }
                          }, function(data){
                              marker=data;
                              marker.fitbounds();
                          })
                      }
                  }
              });
          }
      </script>
    
 </div>

 <?php require 'footer.php' ?>