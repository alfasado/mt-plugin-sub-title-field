package SubTitleField::Plugin;

use strict;

sub _cb_tpl_pram_edit_entry {
    my ( $cb, $app, $param, $tmpl ) = @_;
    my $plugin = MT->component( 'SubTitleField' );
    my $blog_id = $app->blog->id;
    if ( $app->param( '_type' ) eq 'entry' ) {
        my $setting_entry = $plugin->get_config_value( 'subtitlefield_entry', 'blog:' . $blog_id );
        if (! $setting_entry ) {
            return;
        }
    } elsif ( $app->param( '_type' ) eq 'page' ) {
        my $setting_page = $plugin->get_config_value( 'subtitlefield_page', 'blog:' . $blog_id );
        if (! $setting_page ) {
            return;
        }
    }
    my $source = $plugin->get_config_value( 'subtitlefield_text', 'blog:' . $blog_id );
    my $title = $tmpl->getElementById( 'title' );
    $title->innerHTML( $source );
}

sub _hdlr_entry_subtitle {
    my ( $ctx, $args, $cond ) = @_;
    my $entry = $ctx->stash( 'entry' ) || return '';
    return $entry->subtitle;
}

sub _filter_subtitle {
    my ( $ctx, $args, $cond ) = @_;
    my $terms = $ctx->{ terms };
    if ( my $subtitle = $args->{ subtitle } ) {
        $terms->{ subtitle } = $subtitle;
    } elsif ( my $incl_subtitle = $args->{ incl_subtitle } ) {
        my $param = '%' . $incl_subtitle . '%';
        $terms->{ subtitle } = { like => $param };
    }
}

1;