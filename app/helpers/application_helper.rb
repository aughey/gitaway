module ApplicationHelper
  def l(obj)
    if obj.respond_to? 'path'
      link_to(obj,obj.path)
    else
      link_to(obj,obj)
    end
  end

  def header
    render :partial => 'header'
  end

  def commit(c)
    render :partial => 'commit', :object => c
  end

  def blob_link(r,branch,prefix,b)
    if branch
      link_to(b.name,"#{r.path}/#{branch}#{prefix}/#{b.name}")
    else
      link_to(b.name,"#{r.path}/blob/#{b.id}")
    end
  end

  def tree_link(r,branch,prefix,t)
    if branch
      link_to("[D]" + t.name,"#{r.path}/#{branch}#{prefix}/#{t.name}")
    else
      link_to("[D]" + t.name,"#{r.path}/tree/#{t.id}")
    end
  end
end
