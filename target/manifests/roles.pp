define role
{
  $node_classes = hiera("${name}_classes", '')
  if $node_classes {
    include $node_classes
    $s = join($node_classes, ' ')
    notice("Classes: ${s}")
  }
}
