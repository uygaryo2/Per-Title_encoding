WITH clip_data AS
(
	SELECT 
		id AS 'clip_id',
        duration AS 'clip_duration',
        size as 'clip_size',
        width AS 'clip_width',
        height AS 'clip_height',
        sample_aspect_ratio AS 'clip_sample_aspect_ratio',
        display_aspect_ratio AS 'display_aspect_ratio',
        bitrate_total AS 'clip_bitrate_total',
        video_profile,
        frame_rate AS 'clip_frame_rate'
	FROM awt.clip
),

encode_data AS
(
	SELECT 
		id AS 'encode_id',
		width AS 'encode_width',
		height AS 'encode_height',
		crf,
		psnr,
		vmaf,
		bitrate_video AS 'encode_bitrate_video',
        clip_id
	FROM awt.encode
)
SELECT 
	e.encode_id,
    e.clip_id,
    e.encode_width,
    e.encode_height,
    c.clip_width,
    c.clip_height,
    c.clip_duration,
    c.clip_size,
    c.clip_bitrate_total,
    c.video_profile,
    c.clip_frame_rate,
    e.crf,
    e.encode_bitrate_video,
    e.psnr,
    e.vmaf
FROM encode_data as e, clip_data as c
WHERE e.clip_id = c.clip_id
AND e.clip_id = 5;
