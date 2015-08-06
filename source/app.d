import std.stdio;
import dtiled.data;
import std.path : buildPath, setExtension;
import std.conv;
import tkd.tkdapplication;
import tkd.image.image;

class Application : TkdApplication
{

    public int height = 200;
    public int width = 200;

    private void exitCommand(CommandArgs args)
    {
        this.exit();
    }

    override protected void initInterface()
    {

        enum imgPath(string name) = buildPath("resources",
            name).setExtension("png");

        // Need image reader that can pass a partial sprite
        // over to the Image class for tkd
        // terrain.png is made up of 4 32x32 tiles
        auto tileOne = new Image()
          .setFile(imgPath!"terrain")
          .setWidth(32)
          .setHeight(32);

        auto canvas = new Canvas(Color.white)
          .setWidth(this.width)
          .setHeight(this.height)
          .addItem(new CanvasImage([0, 0], tileOne,
                "AnchorPosition.northWest"))
          .pack();

        auto frame = new Frame(2, ReliefStyle.groove)
              .pack(10);

        auto exitButton = new Button(frame, "Exit")
            .setCommand(&this.exitCommand)
            .pack(10);
    }
}

void main()
{
  // Create a variable that takes a file name as a compile time argument
  enum testPath(string name) = buildPath("resources", name).setExtension("json");

  // Load a map
  auto map = MapData.load(testPath!"tiles");

  writeln("");

  // Read some values
  writeln("Num Rows: "         ~ to!string(map.numRows)         );
  writeln("Num Cols: "         ~ to!string(map.numCols)         );
  writeln("Tile Width: "       ~ to!string(map.tileWidth)       );
  writeln("Tile Height: "      ~ to!string(map.tileHeight)      );
  writeln("Render Order: "     ~ to!string(map.renderOrder)     );
  writeln("Orientation: "      ~ to!string(map.orientation)     );
  writeln("Background Color: " ~ to!string(map.backgroundColor) );

  writeln("");

  writeln("Total Map Layers: " ~ to!string(map.layers.length)   );

  foreach (i; 0 .. map.layers.length) {

    writeln("Layer Number " ~ to!string(i)                      );
    writeln("  Name: " ~      to!string(map.layers[i].name)     );
    writeln("  Data: " ~      to!string(map.layers[i].data)     );
    writeln("  Num Rows: " ~  to!string(map.layers[i].numRows)  );
    writeln("  Num Cols: " ~  to!string(map.layers[i].numCols)  );
    writeln("  Opacity:  " ~  to!string(map.layers[i].opacity)  );
    writeln("  Type: " ~      to!string(map.layers[i].type)     );
    writeln("  Visible: " ~   to!string(map.layers[i].visible)  );
    writeln("  X: " ~         to!string(map.layers[i].x)        );
    writeln("  Y: " ~         to!string(map.layers[i].y)        );

    writeln("  Get Layer By Name: " ~ to!string( map.getLayer(
            map.layers[i].name ) ) );

  }

  writeln("");

  writeln("Total Tilesets: " ~ to!string(map.tilesets.length)   );

  foreach (i; 0 .. map.tilesets.length) {

    writeln("Tileset Number " ~  to!string(i)                            );
    writeln("  Name: " ~         to!string(map.tilesets[i].name)         );
    writeln("  First GID: " ~    to!string(map.tilesets[i].firstGid)     );
    writeln("  Image Height: " ~ to!string(map.tilesets[i].imageHeight)  );
    writeln("  Image Width: " ~  to!string(map.tilesets[i].imageWidth)   );
    writeln("  Margin:  " ~      to!string(map.tilesets[i].margin)       );
    writeln("  Tile Height: " ~  to!string(map.tilesets[i].tileHeight)   );
    writeln("  Tile Width: " ~   to!string(map.tilesets[i].tileWidth)    );
    writeln("  Spacing: " ~      to!string(map.tilesets[i].spacing)      );

    // Properties
    writeln("  Num Rows: " ~     to!string(map.tilesets[i].numRows)      );
    writeln("  Num Cols: " ~     to!string(map.tilesets[i].numCols)      );
    writeln("  Num Tiles: " ~    to!string(map.tilesets[i].numTiles)     );

    writeln("  Get Tileset By Name: " ~ to!string( map.getTileset(
            map.tilesets[i].name ) ) );

  }

  writeln("");

  auto app = new Application(); 
  app.run(); 

  // Using this as my guide for starting to probe this library
  // https://github.com/rcorre/dtiled/blob/master/tests/data.d#L2

}
