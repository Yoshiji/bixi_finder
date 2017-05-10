class BixiStationPresenter < BasePresenter

  def initialize(record, view, other_attrs_as_hash)
    @other_attrs_as_hash = other_attrs_as_hash || {}
    super(record, view)
  end

  def available_bikes
    @other_attrs_as_hash['ba']
  end

  def bixi_checked_at
    if @other_attrs_as_hash['lc']
      h.l(Time.at(@other_attrs_as_hash['lc']/1000), format: :short)
    end
  end

  def bixi_checked_at_ago_in_words
    if @other_attrs_as_hash['lc']
      h.time_ago_in_words(Time.at(@other_attrs_as_hash['lc']/1000))
    end
  end

  def distance_to_fx_innovation_with_units
    "#{self.distance_to_fx_innovation} #{h.t('units.kilometers_short')}"
  end

  def useable_str
    if @other_attrs_as_hash['b'] || @other_attrs_as_hash['su'] || @other_attrs_as_hash['m']
      h.t('common.no')
    elsif !@other_attrs_as_hash['b'].nil? && !@other_attrs_as_hash['su'].nil? && !@other_attrs_as_hash['m'].nil?
      # means we received only false values
      h.t('common.yes')
    end
  end

  def useable?
    !(@other_attrs_as_hash['b'] || @other_attrs_as_hash['su'] || @other_attrs_as_hash['m'])
  end
end