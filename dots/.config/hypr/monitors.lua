hl.monitor({
	output = "DP-2",
	mode = "3840x2160@160",
	position = "0x0",
	scale = 1.5,
	bitdepth = 10,
	cm = "srgb",
	-- cm = "hdr",
	sdrbrightness = 1.0,
	sdrsaturation = 1.0,
	sdr_min_luminance = 0.2,
	sdr_max_luminance = 250,
	min_luminance = 60,
	max_luminance = 1600,
	max_avg_luminance = 1600,
})

hl.monitor({
	output = "HDMI-A-2",
	mode = "3840x2160@48",
	-- mode = "3840x2160@60",
	-- mode = "3840x2160@120",
	position = "auto-up",
	cm = "srgb",
	scale = 2.5,
	bitdepth = 10,
	vrr = 0,
})
