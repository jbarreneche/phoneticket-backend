# Phoneticket backend

## API

### Películas

Para obtener las películas en cartelera (sólo trae las que tengan alguna función en el futuro)

`curl http://phoneticket-stg.herokuapp.com/api/movies`

```json
[
  {
    "id": 1,
    "title": "Matrix",
    "synopsis": "¿Es el mundo lo que parece? Thomas Anderson (Keanu Reeves), programador de una importante empresa de software y asaltador informático de alias Neo, averiguará que no. Con él contactará un extraño grupo encabezado por Morfeo (Lawrence Fishburne), quien le mostrará la verdadera realidad que se esconde tras lo aparente: un mundo dominado por las máquinas, las cuales esclavizan a la Humanidad para utilizar nuestros cuerpos como simple fuente de energía. ¿Pero, y nuestra mente, dónde se encuentra entonces? la respuesta está en Matrix.\n",
    "youtube_trailer": "http://www.youtube.com/watch?v=m8e-FF8MsqU",
    "director": "Hermanos Wachowski",
    "audience_rating": "PG-13",
    "cast": "Keanu Reeves y Laurence Fishburne",
    "genre": "Ciencia Ficción",
    "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784126/o79sbfmrbuqlcryfbuiw.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/movies/1"
  },
  {
    "id": 4,
    "title": "Starsky y Hutch",
    "synopsis": "El detective David Starsky (Ben Stiller) es el policía secreto más entregado a su trabajo en las peligrosas calles de Bay City, California. Su trabajo lo tiene completamente absorbido: cuando está de servicio ningún delito queda impune y él nunca abandona. El detective Ken “Hutch” Hutchinson (Owen Wilson) no se encuentra en el mejor momento de su carrera: es un buen policía, pero su personalidad un tanto pasota y su debilidad por el dinero fácil no es la mejor tarjeta de presentación. Tiene un instinto fabuloso, pero tiene que hacer un esfuerzo para permanecer en el lado de la ley, aunque resulte menos rentable. Dobey (Fred Williamson), el exasperado capitán de la policía de Bay City, ha dado con la solución perfecta para sus dos problemas más engorrosos: emparejar a Starsky y Hutch y enviarlos a las calles. Precisamente el mismo día en que estos dos dispares agentes comienzan a trabajar juntos sin demasiadas ganas, aparece un \"flotador\" en las aguas de Bay City. Con la ayuda de Huggy Bear (Snoop Dogg), el imprevisible y curtido soplón de Hutch, ambos comienzan a desenredar el misterioso caso de homicidio. Todas los indicios señalan al rico empresario Reese Feldman (Vince Vaughn), pero Starsky y Hutch no consiguen encontrar pruebas que lo incriminen. Sin que ellos lo sepan, Feldman ha urdido un plan para engañar a la DEA y está tramando la operación de tráfico de drogas más importante y lucrativa de su carrera. Este dispar dúo recurrirá a sus tácticas secretas más astutas, a sus triquiñuelas callejeras más pícaras y a su innegable atractivo físico para resolver el caso y asegurarse que el culpable cumple su pena.",
    "youtube_trailer": "http://www.youtube.com/watch?v=NEdYFOPRI0A",
    "director": "Someone",
    "audience_rating": "ATP",
    "cast": "Someone Else",
    "genre": "Acción",
    "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379904210/ng5lp5otbi6rrrhzwsto.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/movies/4"
  },
  {
    "id": 2,
    "title": "Aviones",
    "synopsis": "Desde las alturas del mundo de “Cars” llega la película de Disney “Aviones”. La nueva película de animación en 3D llena de acción y aventuras, protagonizada por Dusty (voz de Dane Cook), un avión que sueña con participar en una competición aérea de altos vuelos. Pero Dusty no fue precisamente construido para competir y resulta que... ¡tiene miedo a las alturas! Así que, recurre a un experimentado aviador naval que le ayuda a clasificarse para retar al vigente campeón del circuito de carreras. Dusty demostrará su valor para alcanzar alturas inimaginables y enseñará al mundo lo que hay que hacer para levantar el vuelo. La película de Disney “Aviones” despega en agosto de 2013 y estará disponible en Disney Digital 3D™ en una selección de cines.\n",
    "youtube_trailer": "http://www.youtube.com/watch?v=YRjztG65XgI",
    "director": "Klay Hall",
    "audience_rating": "ATP",
    "cast": "Val Kilmer y Julia Louis-Dreyfus",
    "genre": "Animación",
    "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784107/becmvk91thejcvktghmd.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/movies/2"
  },
  {
    "id": 3,
    "title": "Zoolander",
    "synopsis": "Derek Zoolander (Ben Stiller) es el modelo masculino más famoso del mundo, ganador durante tres años consecutivos del premio de \"Modelo del Año\". Derek está muy nervioso, pues este año tiene seria competencia por parte de Hansel (Owen Wilson), un rubio modelo, más joven que Derek, y con una actitud mucho más en línea con la de la juventud actual. Mientras que Derek ocupa su tiempo desarrollando la expresión facial que lo ha hecho famoso, Hansel lo invierte participando en deportes extremos y actividades de iluminación espiritual. Mientras tanto, un consorcio mundial de modas acostumbrado a utilizar mano de obra infantil en países tercermundistas se ve amenazado por las reformas laborales que el primer ministro de Malasia desea implementar. El consorcio no puede permitir esto, por lo que deciden eliminar al jefe de estado, tarea que le encargan al Mugatu, un mundialmente famoso diseñador de modas, quien desarrolla un plan para que Zoolander tenga un papel preponderante en el asesinato.",
    "youtube_trailer": "http://www.youtube.com/watch?v=YtQq0T3ExLs",
    "director": null,
    "audience_rating": null,
    "cast": "",
    "genre": null,
    "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379903614/xietzrxtvv8cebsio5t1.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/movies/3"
  }
]
```

Para obtener las funciones de una determinada película

`curl http://phoneticket-stg.herokuapp.com/api/movies/1`

```json
{
  "id": 1,
  "title": "Matrix",
  "synopsis": "¿Es el mundo lo que parece? Thomas Anderson (Keanu Reeves), programador de una importante empresa de software y asaltador informático de alias Neo, averiguará que no. Con él contactará un extraño grupo encabezado por Morfeo (Lawrence Fishburne), quien le mostrará la verdadera realidad que se esconde tras lo aparente: un mundo dominado por las máquinas, las cuales esclavizan a la Humanidad para utilizar nuestros cuerpos como simple fuente de energía. ¿Pero, y nuestra mente, dónde se encuentra entonces? la respuesta está en Matrix.\n",
  "youtube_trailer": "http://www.youtube.com/watch?v=m8e-FF8MsqU",
  "director": "Hermanos Wachowski",
  "audience_rating": "PG-13",
  "cast": "Keanu Reeves y Laurence Fishburne",
  "genre": "Ciencia Ficción",
  "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784126/o79sbfmrbuqlcryfbuiw.jpg",
  "theatres": [
    {
      "id": 1,
      "name": "Cine 1",
      "latitude": "-34.617811",
      "longitude": "-58.368222",
      "address": "Avenida Paseo Colón 850",
      "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
      "shows": [
        {
          "id": 13,
          "starts_at": "2013-10-03T19:00:00.000Z",
          "room": {
            "id": 1,
            "theatre_id": 1,
            "name": "Sala 1",
            "shape": "standard",
            "created_at": "2013-09-21T02:55:54.897Z",
            "updated_at": "2013-09-21T02:55:54.897Z"
          }
        },
        {
          "id": 14,
          "starts_at": "2013-10-03T20:30:00.000Z",
          "room": {
            "id": 2,
            "theatre_id": 1,
            "name": "Sala 2",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.906Z",
            "updated_at": "2013-09-28T20:58:01.316Z"
          }
        },
        {
          "id": 16,
          "starts_at": "2013-10-03T21:30:00.000Z",
          "room": {
            "id": 1,
            "theatre_id": 1,
            "name": "Sala 1",
            "shape": "standard",
            "created_at": "2013-09-21T02:55:54.897Z",
            "updated_at": "2013-09-21T02:55:54.897Z"
          }
        },
        {
          "id": 17,
          "starts_at": "2013-10-03T19:00:00.000Z",
          "room": {
            "id": 2,
            "theatre_id": 1,
            "name": "Sala 2",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.906Z",
            "updated_at": "2013-09-28T20:58:01.316Z"
          }
        }
      ]
    },
    {
      "id": 2,
      "name": "Cine 2",
      "latitude": "-34.588333",
      "longitude": "-58.396208",
      "address": "Avenida Paseo Colón 2214",
      "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
      "shows": [
        {
          "id": 15,
          "starts_at": "2013-10-03T21:00:00.000Z",
          "room": {
            "id": 3,
            "theatre_id": 2,
            "name": "Sala 1",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.913Z",
            "updated_at": "2013-09-28T20:58:01.328Z"
          }
        },
        {
          "id": 18,
          "starts_at": "2013-10-03T20:30:00.000Z",
          "room": {
            "id": 3,
            "theatre_id": 2,
            "name": "Sala 1",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.913Z",
            "updated_at": "2013-09-28T20:58:01.328Z"
          }
        }
      ]
    }
  ]
}
```

### Complejos

Para obtener los complejos (puede traer complejos que no tengan películas en cartelera)

`curl http://phoneticket-stg.herokuapp.com/api/theatres`

```json
[
  {
    "id": 1,
    "name": "Cine 1",
    "latitude": "-34.617811",
    "longitude": "-58.368222",
    "address": "Avenida Paseo Colón 850",
    "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/theatres/1"
  },
  {
    "id": 2,
    "name": "Cine 2",
    "latitude": "-34.588333",
    "longitude": "-58.396208",
    "address": "Avenida Paseo Colón 2214",
    "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/theatres/2"
  },
  {
    "id": 3,
    "name": "Cine 3",
    "latitude": "-34.599709",
    "longitude": "-58.397981",
    "address": "Avenida Córdoba 2122",
    "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
    "resource_url": "http://phoneticket-stg.herokuapp.com/api/theatres/3"
  }
]
```

Para obtener la cartelera de un complejo

`curl http://phoneticket-stg.herokuapp.com/api/theatre/1`

```json
{
  "id": 1,
  "name": "Cine 1",
  "latitude": "-34.617811",
  "longitude": "-58.368222",
  "address": "Avenida Paseo Colón 850",
  "photo_url": "http://phoneticket-stg.herokuapp.com/assets/no-theatre-photo-375b89f945df0565117e5b92de5e4adb.jpg",
  "movies": [
    {
      "id": 1,
      "title": "Matrix",
      "synopsis": "¿Es el mundo lo que parece? Thomas Anderson (Keanu Reeves), programador de una importante empresa de software y asaltador informático de alias Neo, averiguará que no. Con él contactará un extraño grupo encabezado por Morfeo (Lawrence Fishburne), quien le mostrará la verdadera realidad que se esconde tras lo aparente: un mundo dominado por las máquinas, las cuales esclavizan a la Humanidad para utilizar nuestros cuerpos como simple fuente de energía. ¿Pero, y nuestra mente, dónde se encuentra entonces? la respuesta está en Matrix.\n",
      "youtube_trailer": "http://www.youtube.com/watch?v=m8e-FF8MsqU",
      "director": "Hermanos Wachowski",
      "audience_rating": "PG-13",
      "cast": "Keanu Reeves y Laurence Fishburne",
      "genre": "Ciencia Ficción",
      "cover_url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784126/o79sbfmrbuqlcryfbuiw.jpg",
      "shows": [
        {
          "id": 14,
          "starts_at": "2013-10-03T20:30:00.000Z",
          "room": {
            "id": 2,
            "theatre_id": 1,
            "name": "Sala 2",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.906Z",
            "updated_at": "2013-09-28T20:58:01.316Z"
          }
        },
        {
          "id": 17,
          "starts_at": "2013-10-03T19:00:00.000Z",
          "room": {
            "id": 2,
            "theatre_id": 1,
            "name": "Sala 2",
            "shape": "small",
            "created_at": "2013-09-21T02:55:54.906Z",
            "updated_at": "2013-09-28T20:58:01.316Z"
          }
        },
        {
          "id": 13,
          "starts_at": "2013-10-03T19:00:00.000Z",
          "room": {
            "id": 1,
            "theatre_id": 1,
            "name": "Sala 1",
            "shape": "standard",
            "created_at": "2013-09-21T02:55:54.897Z",
            "updated_at": "2013-09-21T02:55:54.897Z"
          }
        },
        {
          "id": 16,
          "starts_at": "2013-10-03T21:30:00.000Z",
          "room": {
            "id": 1,
            "theatre_id": 1,
            "name": "Sala 1",
            "shape": "standard",
            "created_at": "2013-09-21T02:55:54.897Z",
            "updated_at": "2013-09-21T02:55:54.897Z"
          }
        }
      ]
    }
  ]
}
```


### Usuarios

#### Para registrar un nuevo usuario

`curl http://phoneticket-stg.herokuapp.com/api/users -d '{"email": "email@gmail.com", "password": "123456"}' -H 'Content-Type: application/json'`

```json
{
  "email": "email@gmail.com",
  "first_name": null,
  "last_name": null,
  "phone_number": null,
  "date_of_birth": null,
  "document": null,
  "address": null
}
```

Ejemplo de errores:

`curl http://phoneticket-stg.herokuapp.com/api/users -d '{"email": "email@gmail.com"}' -H 'Content-Type: application/json'`

Headers

```
  HTTP/1.1 422 Unprocessable Entity
```

BODY:

```json
{
  "errors": {
    "password": [
      "no puede estar en blanco"
    ]
  },
  "email": "email@gmail.com",
  "first_name": null,
  "last_name": null,
  "phone_number": null,
  "date_of_birth": null,
  "document": null,
  "address": null
}
```

#### Para hacer login de un usuario


`curl http://phoneticket-stg.herokuapp.com/api/users/sessions -d '{"email": "snipperme@gmail.com", "password": "123456"}' -H 'Content-Type: application/json'`

```json
{
  "email": "snipperme@gmail.com",
  "first_name": "",
  "last_name": "",
  "phone_number": "",
  "date_of_birth": null,
  "document": "123456",
  "address": ""
}
```

#### Para consultar la información de un determinado usuario


`curl http://phoneticket-stg.herokuapp.com/api/users/me\?email\=snipperme@gmail.com`

```json
{
    "email": "snipperme@gmail.com",
    "first_name": "Juani",
    "last_name": "Barren",
    "phone_number": "123456",
    "date_of_birth": "1922-09-02",
    "document": "31376588",
    "address": "Cevallos 656",
    "purchases": [
        {
            "id": 33,
            "seats": [
                "b-6",
                "b-5"
            ],
            "show": {
                "id": 51,
                "starts_at": "2013-10-17T19:00:00.000Z",
                "theatre": {
                  "id": 3,
                  "name": "Cine 3"
                },
                "room": {
                    "id": 6,
                    "theatre_id": 3,
                    "name": "Sala 2",
                    "shape": "small",
                    "created_at": "2013-09-21T02:55:54.944Z",
                    "updated_at": "2013-09-28T20:58:01.342Z"
                },
                "movie": {
                    "id": 2,
                    "title": "Aviones",
                    "synopsis": "Desde las alturas del mundo de “Cars” llega la película de Disney “Aviones”. La nueva película de animación en 3D llena de acción y aventuras, protagonizada por Dusty (voz de Dane Cook), un avión que sueña con participar en una competición aérea de altos vuelos. Pero Dusty no fue precisamente construido para competir y resulta que... ¡tiene miedo a las alturas! Así que, recurre a un experimentado aviador naval que le ayuda a clasificarse para retar al vigente campeón del circuito de carreras. Dusty demostrará su valor para alcanzar alturas inimaginables y enseñará al mundo lo que hay que hacer para levantar el vuelo. La película de Disney “Aviones” despega en agosto de 2013 y estará disponible en Disney Digital 3D™ en una selección de cines.\n",
                    "youtube_trailer": "http://www.youtube.com/watch?v=YRjztG65XgI",
                    "created_at": "2013-09-21T02:55:54.992Z",
                    "updated_at": "2013-10-12T15:11:19.523Z",
                    "cover": {
                        "url": "http://res.cloudinary.com/he9oj48ys/image/upload/v1379784107/becmvk91thejcvktghmd.jpg",
                        "admin": {
                            "url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_160,w_120/v1379784107/becmvk91thejcvktghmd.jpg"
                        },
                        "android": {
                            "url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784107/becmvk91thejcvktghmd.jpg"
                        }
                    },
                    "cast": [
                        "Val Kilmer",
                        "Julia Louis-Dreyfus"
                    ],
                    "director": "Klay Hall",
                    "country": "Estados Unidos",
                    "genre": "animation",
                    "audience_rating": "ATP"
                }
            }
        }
    ],
    "reservations": [
        {
            "id": 27,
            "seats": [
                "a-3",
                "a-2"
            ],
            "show": {
                "id": 49,
                "starts_at": "2013-10-17T23:15:00.000Z",
                "theatre": {
                  "id": 2,
                  "name": "Cine 2"
                },
                "room": {
                    "id": 4,
                    "theatre_id": 2,
                    "name": "Sala 2",
                    "shape": "standard",
                    "created_at": "2013-09-21T02:55:54.925Z",
                    "updated_at": "2013-09-21T02:55:54.925Z"
                },
                "movie": {
                    "id": 2,
                    "title": "Aviones",
                    "synopsis": "Desde las alturas del mundo de “Cars” llega la película de Disney “Aviones”. La nueva película de animación en 3D llena de acción y aventuras, protagonizada por Dusty (voz de Dane Cook), un avión que sueña con participar en una competición aérea de altos vuelos. Pero Dusty no fue precisamente construido para competir y resulta que... ¡tiene miedo a las alturas! Así que, recurre a un experimentado aviador naval que le ayuda a clasificarse para retar al vigente campeón del circuito de carreras. Dusty demostrará su valor para alcanzar alturas inimaginables y enseñará al mundo lo que hay que hacer para levantar el vuelo. La película de Disney “Aviones” despega en agosto de 2013 y estará disponible en Disney Digital 3D™ en una selección de cines.\n",
                    "youtube_trailer": "http://www.youtube.com/watch?v=YRjztG65XgI",
                    "created_at": "2013-09-21T02:55:54.992Z",
                    "updated_at": "2013-10-12T15:11:19.523Z",
                    "cover": {
                        "url": "http://res.cloudinary.com/he9oj48ys/image/upload/v1379784107/becmvk91thejcvktghmd.jpg",
                        "admin": {
                            "url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_160,w_120/v1379784107/becmvk91thejcvktghmd.jpg"
                        },
                        "android": {
                            "url": "http://res.cloudinary.com/he9oj48ys/image/upload/c_fill,h_320,w_240/v1379784107/becmvk91thejcvktghmd.jpg"
                        }
                    },
                    "cast": [
                        "Val Kilmer",
                        "Julia Louis-Dreyfus"
                    ],
                    "director": "Klay Hall",
                    "country": "Estados Unidos",
                    "genre": "animation",
                    "audience_rating": "ATP"
                }
            }
        }
    ]
}
```

### Funciones

#### Para consultar el estado de ocupación de una determinada función

`curl http://phoneticket-stg.herokuapp.com/api/shows/51`

```json
{
  "status": {
    "left": {
      "rows": [
        "a",
        "b"
      ],
      "columns": [
        "1",
        "2"
      ],
      "seats": [
        [
          "a-1",
          "a-2"
        ],
        [
          "b-1",
          "b-2"
        ]
      ],
      "void_seats": [
        "a-1"
      ],
      "reserved_seats": []
    },
    "middle": {
      "rows": [
        "a",
        "b"
      ],
      "columns": [
        "3",
        "4"
      ],
      "seats": [
        [
          "a-3",
          "a-4"
        ],
        [
          "b-3",
          "b-4"
        ]
      ],
      "void_seats": [],
      "reserved_seats": []
    },
    "right": {
      "rows": [
        "a",
        "b"
      ],
      "columns": [
        "5",
        "6"
      ],
      "seats": [
        [
          "a-5",
          "a-6"
        ],
        [
          "b-5",
          "b-6"
        ]
      ],
      "void_seats": [
        "a-6"
      ],
      "reserved_seats": [
        "b-6",
        "b-5"
      ]
    }
  }
}
```
