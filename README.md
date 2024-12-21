# LogFox

 Simple godot logger plugin with dock to see old logs.

![1734691977870](image/README/1734691977870.png)

![1734692001689](image/README/1734692001689.png)

## Usage

### Logging info
```gdscript
LogFox.info("Some info", source_node)
LogFox.warning("Some warning", source_node)
LogFox.error("Some error", source_node)
```
### Log variable values
```gdscript
# Connect it to variable change
LogFox.log_property(source_node, "property_name")
# It can't get function(local) variables, make it global first
```
