create trigger match_display_size
    after insert or update
    on bases
    for each row execute procedure match_display_size();
create trigger match_gpu_allowed
    after insert or update
    on builds
    for each row execute procedure match_gpu_allowed();

