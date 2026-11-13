<?php
function media_embed_url($url, $autoplay = false)
{
  $url = trim((string) $url);
  $parts = parse_url($url);
  $scheme = strtolower($parts['scheme'] ?? '');
  $host = strtolower($parts['host'] ?? '');
  $path = $parts['path'] ?? '';

  if (!in_array($scheme, ['http', 'https'], true) || $host === '') {
    return '';
  }

  $host = preg_replace('/^www\./', '', $host);

  if (in_array($host, ['youtu.be', 'youtube.com', 'youtube-nocookie.com', 'music.youtube.com'], true)) {
    parse_str($parts['query'] ?? '', $query);
    $videoId = '';
    $playlistId = '';

    if ($host === 'youtu.be') {
      $videoId = trim($path, '/');
    } elseif (preg_match('#/(?:embed|shorts|live)/([^/]+)#', $path, $matches)) {
      $videoId = $matches[1];
    } else {
      $videoId = $query['v'] ?? '';
      if (strpos($path, '/playlist') === 0) {
        $playlistId = $query['list'] ?? '';
      }
    }

    $playerParams = $autoplay ? '?autoplay=1&playsinline=1' : '';
    if ($videoId !== '' && preg_match('/^[A-Za-z0-9_-]+$/', $videoId)) {
      return 'https://www.youtube-nocookie.com/embed/' . rawurlencode($videoId) . $playerParams;
    }

    if ($playlistId !== '' && preg_match('/^[A-Za-z0-9_-]+$/', $playlistId)) {
      return 'https://www.youtube-nocookie.com/embed/videoseries?list=' . rawurlencode($playlistId)
        . ($autoplay ? '&autoplay=1&playsinline=1' : '');
    }

    return '';
  }

  if ($host === 'open.spotify.com') {
    if (preg_match('#^/embed/(episode|track|show|playlist|album)/([^/?]+)#', $path, $matches)) {
      return 'https://open.spotify.com/embed/' . $matches[1] . '/' . rawurlencode($matches[2]);
    }
    if (preg_match('#^/(episode|track|show|playlist|album)/([^/?]+)#', $path, $matches)) {
      return 'https://open.spotify.com/embed/' . $matches[1] . '/' . rawurlencode($matches[2]);
    }
    return '';
  }

  if ($host === 'soundcloud.com') {
    return 'https://w.soundcloud.com/player/?url=' . rawurlencode($url) . '&auto_play=false';
  }

  if ($host === 'w.soundcloud.com' && strpos($path, '/player') === 0) {
    return $url;
  }

  return $url;
}

function is_direct_audio_url($url)
{
  $parts = parse_url(trim((string) $url));
  $scheme = strtolower($parts['scheme'] ?? '');
  $path = strtolower($parts['path'] ?? '');

  return in_array($scheme, ['http', 'https'], true)
    && preg_match('/\.(?:mp3|m4a|ogg|wav)(?:$)/', $path) === 1;
}
