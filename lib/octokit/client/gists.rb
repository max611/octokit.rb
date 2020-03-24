# frozen_string_literal: true

module Octokit
  class Client
    # Methods for the Gists API
    #
    # @see https://developer.github.com/v3/gists/
    module Gists
      # Get a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Sawyer::Resource] A single gist
      # @see https://developer.github.com/v3/gists/#get-a-gist
      def gist(gist_id, options = {})
        get "gists/#{Gist.new gist_id}", options
      end

      # List gists for the authenticated user
      #
      # @option options [String] :since This is a timestamp in ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or after this time are returned.
      # @return [Array<Sawyer::Resource>] A list of gists
      # @see https://developer.github.com/v3/gists/#list-gists-for-the-authenticated-user
      def gists(options = {})
        paginate 'gists', options
      end

      # Create a gist
      #
      # @param files [Object] The filenames and content of each file in the gist. The keys in the files object represent the filename and have the type string.
      # @option options [String] :description A descriptive name for this gist.
      # @option options [Boolean] :public When true, the gist will be public and available for anyone to see.
      # @return [Sawyer::Resource] The new gist
      # @see https://developer.github.com/v3/gists/#create-a-gist
      def create_gist(files, options = {})
        opts = options
        opts[:files] = files
        post 'gists', opts
      end

      # Update a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @option options [String] :description A descriptive name for this gist.
      # @option options [Object] :files The filenames and content that make up this gist.
      # @return [Sawyer::Resource] The updated gist
      # @see https://developer.github.com/v3/gists/#update-a-gist
      def update_gist(gist_id, options = {})
        patch "gists/#{Gist.new gist_id}", options
      end

      # Delete a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Boolean] True on success, false otherwise
      # @see https://developer.github.com/v3/gists/#delete-a-gist
      def delete_gist(gist_id, options = {})
        boolean_from_response :delete, "gists/#{Gist.new gist_id}", options
      end

      # Check if a gist is starred
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Boolean] A single starred
      # @see https://developer.github.com/v3/gists/#check-if-a-gist-is-starred
      def is_starred?(gist_id, options = {})
        boolean_from_response :get, "gists/#{Gist.new gist_id}/star", options
      end

      # Get a specific revision of a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @param sha [String] The sha of the revision
      # @return [Sawyer::Resource] A single revision
      # @see https://developer.github.com/v3/gists/#get-a-specific-revision-of-a-gist
      def gist_revision(gist_id, sha, options = {})
        get "gists/#{Gist.new gist_id}/#{sha}", options
      end

      # Get a single comment
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @param comment_id [Integer] The ID of the comment
      # @return [Sawyer::Resource] A single comment
      # @see https://developer.github.com/v3/gists/comments/#get-a-single-comment
      def gist_comment(gist_id, comment_id, options = {})
        get "gists/#{Gist.new gist_id}/comments/#{comment_id}", options
      end

      # List gist forks
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Array<Sawyer::Resource>] A list of forks
      # @see https://developer.github.com/v3/gists/#list-gist-forks
      def gist_forks(gist_id, options = {})
        paginate "gists/#{Gist.new gist_id}/forks", options
      end

      # List starred gists
      #
      # @option options [String] :since This is a timestamp in ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or after this time are returned.
      # @return [Array<Sawyer::Resource>] A list of gists
      # @see https://developer.github.com/v3/gists/#list-starred-gists
      def starred_gists(options = {})
        paginate 'gists/starred', options
      end

      # List gist commits
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Array<Sawyer::Resource>] A list of commits
      # @see https://developer.github.com/v3/gists/#list-gist-commits
      def gist_commits(gist_id, options = {})
        paginate "gists/#{Gist.new gist_id}/commits", options
      end

      # List public gists
      #
      # @option options [String] :since This is a timestamp in ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or after this time are returned.
      # @return [Array<Sawyer::Resource>] A list of gists
      # @see https://developer.github.com/v3/gists/#list-public-gists
      def public_gists(options = {})
        paginate 'gists/public', options
      end

      # List comments on a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Array<Sawyer::Resource>] A list of comments
      # @see https://developer.github.com/v3/gists/comments/#list-comments-on-a-gist
      def gist_comments(gist_id, options = {})
        paginate "gists/#{Gist.new gist_id}/comments", options
      end

      # Create a comment
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @param body [String] The comment text.
      # @return [Sawyer::Resource] The new comment
      # @see https://developer.github.com/v3/gists/comments/#create-a-comment
      def create_gist_comment(gist_id, body, options = {})
        opts = options
        opts[:body] = body
        post "gists/#{Gist.new gist_id}/comments", opts
      end

      # Fork a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Sawyer::Resource] The new gist
      # @see https://developer.github.com/v3/gists/#fork-a-gist
      def fork_gist(gist_id, options = {})
        post "gists/#{Gist.new gist_id}/forks", options
      end

      # Star a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Boolean] True on success, false otherwise
      # @see https://developer.github.com/v3/gists/#star-a-gist
      def star_gist(gist_id, options = {})
        boolean_from_response :put, "gists/#{Gist.new gist_id}/star", options
      end

      # Edit a comment
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @param comment_id [Integer] The ID of the comment
      # @param body [String] The comment text.
      # @return [Sawyer::Resource] The updated comment
      # @see https://developer.github.com/v3/gists/comments/#edit-a-comment
      def update_gist_comment(gist_id, comment_id, body, options = {})
        opts = options
        opts[:body] = body
        patch "gists/#{Gist.new gist_id}/comments/#{comment_id}", opts
      end

      # Unstar a gist
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @return [Boolean] True on success, false otherwise
      # @see https://developer.github.com/v3/gists/#unstar-a-gist
      def unstar_gist(gist_id, options = {})
        boolean_from_response :delete, "gists/#{Gist.new gist_id}/star", options
      end

      # Delete a comment
      #
      # @param gist_id [Integer, String] The ID of the gist
      # @param comment_id [Integer] The ID of the comment
      # @return [Boolean] True on success, false otherwise
      # @see https://developer.github.com/v3/gists/comments/#delete-a-comment
      def delete_gist_comment(gist_id, comment_id, options = {})
        boolean_from_response :delete, "gists/#{Gist.new gist_id}/comments/#{comment_id}", options
      end

      # List gists for a user
      #
      # @param user [Integer, String] A GitHub user id or login
      # @option options [String] :since This is a timestamp in ISO 8601 (https://en.wikipedia.org/wiki/ISO_8601) format: YYYY-MM-DDTHH:MM:SSZ. Only gists updated at or after this time are returned.
      # @return [Array<Sawyer::Resource>] A list of gists
      # @see https://developer.github.com/v3/gists/#list-gists-for-a-user
      def user_gists(user, options = {})
        paginate "#{User.path user}/gists", options
      end
    end
  end
end
