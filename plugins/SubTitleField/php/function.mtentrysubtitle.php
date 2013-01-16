<?php
function smarty_function_mtentrysubtitle ( $args, &$ctx ) {
    $entry = $ctx->stash( 'entry' );
    if (! isset( $entry ) ) {
        return '';
    }
    return $entry->entry_subtitle;
}
?>