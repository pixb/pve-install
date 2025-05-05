#!/usr/bin/env python3
import os
import sys
import json
import hashlib
import logging
from pathlib import Path

def setup_logging(log_dir):
    """Initialize logging system"""
    os.makedirs(log_dir, exist_ok=True)
    logging.basicConfig(
        filename=os.path.join(log_dir, 'find_duplicate_files.log'),
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        encoding="utf-8"
    )

def load_config(config_path):
    """Load configuration file"""
    try:
        with open(config_path, 'r', encoding='utf-8') as f:
            config = json.load(f)
            # Backward compatibility for old config format
            if 'default_priority' not in config:
                config['default_priority'] = 99
            return config
    except FileNotFoundError:
        logging.error(f"Config file {config_path} not found")
        sys.exit(1)
    except json.JSONDecodeError:
        logging.error(f"Invalid config file format: {config_path}")
        sys.exit(1)

def get_file_hash(filepath):
    """Calculate file hash"""
    hasher = hashlib.md5()
    with open(filepath, 'rb') as f:
        while chunk := f.read(8192):
            hasher.update(chunk)
    return hasher.hexdigest()

def find_duplicates(directory, config):
    """Find duplicate files"""
    file_dict = {}
    priority_map = config.get('directory_priority', {})
    
    for root, _, files in os.walk(directory):
        for filename in files:
            filepath = os.path.join(root, filename)
            file_hash = get_file_hash(filepath)
            
            if file_hash in file_dict:
                file_dict[file_hash].append(filepath)
            else:
                file_dict[file_hash] = [filepath]
    
    return {k: v for k, v in file_dict.items() if len(v) > 1}

def process_duplicates(duplicates, config):
    """Process duplicate files"""
    priority_map = config.get('directory_priority', {})
    default_priority = config.get('default_priority', 99)
    
    for file_hash, file_list in duplicates.items():
        # Sort files by directory priority
        file_list.sort(key=lambda x: priority_map.get(os.path.basename(os.path.dirname(x)), default_priority))
        
        # Log kept file
        kept_file = file_list[0]
        kept_priority = priority_map.get(os.path.basename(os.path.dirname(kept_file)), default_priority)
        logging.info(f"Kept file: {kept_file} (priority: {kept_priority})")
        print(f"Kept file: {kept_file}")
        
        # Remove duplicate files
        for filepath in file_list[1:]:
            try:
                os.remove(filepath)
                removed_priority = priority_map.get(os.path.basename(os.path.dirname(filepath)), default_priority)
                logging.info(f"Removed duplicate: {filepath} (priority: {removed_priority})")
                print(f"Removed duplicate: {filepath}")
            except OSError as e:
                error_msg = f"Failed to remove file {filepath}: {e}"
                logging.error(error_msg)
                print(error_msg)

def main():
    if len(sys.argv) < 2 or len(sys.argv) > 3:
        print("Usage: python find_duplicate_files.py <directory> [config_file]")
        sys.exit(1)
    
    target_dir = sys.argv[1]
    if not os.path.isdir(target_dir):
        print(f"Error: {target_dir} is not a valid directory")
        sys.exit(1)
    
    # Setup paths
    script_dir = os.path.dirname(os.path.abspath(__file__))
    log_dir = os.path.join(script_dir, 'log')
    
    # Initialize logging and console output
    setup_logging(log_dir)
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    logging.getLogger().addHandler(console_handler)
    
    # Load configuration
    if len(sys.argv) == 3:
        config_path = sys.argv[2]
    else:
        config_dir = os.path.join(script_dir, 'config')
        config_path = os.path.join(config_dir, 'find_duplicate_files_config.json')
    config = load_config(config_path)
    # print box header
    logging.info("=" * 80)
    logging.info(f"Duplicate file finder for {target_dir}")
    logging.info("=" * 80)
    # Find and process duplicates
    duplicates = find_duplicates(target_dir, config)
    if duplicates:
        logging.info(f"Found {len(duplicates)} groups of duplicate files")
        process_duplicates(duplicates, config)
    else:
        logging.info("No duplicate files found")

if __name__ == '__main__':
    main()
